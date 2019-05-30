# frozen_string_literal: true

RSpec.describe BatchProcessor::Batch::Processor, type: :module do
  include_context "with an example batch", described_class

  it { is_expected.to delegate_method(:processor_class).to(:class) }
  it { is_expected.to delegate_method(:processor_options).to(:class) }

  shared_examples_for "a processor strategy resolver" do |strategy|
    subject(:resolver) { example_batch_class.__send__("with_#{strategy}_processor".to_sym) }

    it "assigns class" do
      expect { resolver }.
        to change { example_batch_class.instance_variable_get(:@processor_class) }.
        from(nil).
        to(described_class::PROCESSOR_CLASS_BY_STRATEGY[strategy])
    end
  end

  describe ".with_sequential_processor" do
    it_behaves_like "a processor strategy resolver", :sequential
  end

  describe ".with_parallel_processor" do
    it_behaves_like "a processor strategy resolver", :parallel
  end

  describe ".processor_class" do
    subject(:processor_class) { example_batch_class.__send__(:processor_class) }

    context "with @processor_class" do
      before { example_batch_class.__send__(:with_sequential_processor) }

      it { is_expected.to eq described_class::PROCESSOR_CLASS_BY_STRATEGY[:sequential] }
    end

    context "without @processor_class" do
      it { is_expected.to eq described_class::PROCESSOR_CLASS_BY_STRATEGY[:default] }
    end
  end

  describe ".processor_option" do
    subject(:processor_option) { example_batch_class.__send__(:processor_option, option, value) }

    let(:option) { Faker::Internet.domain_word.to_sym }
    let(:value) { SecureRandom.hex }

    shared_examples_for "option is set" do
      let(:expected) { existing.merge(option => value) }

      before { example_batch_class._processor_options.merge! existing }

      it "sets option" do
        expect { processor_option }.to change { example_batch_class._processor_options }.from(existing).to(expected)
      end
    end

    context "with existing options" do
      let(:existing) { Hash[*Faker::Lorem.words(2 * rand(1..2))] }

      it_behaves_like "option is set"
    end

    context "without existing options" do
      let(:existing) { {} }

      it_behaves_like "option is set"
    end
  end

  describe ".inherited" do
    it_behaves_like "an inherited property", :processor_option do
      let(:root_class) { example_batch_class }
      let(:expected_attribute_value) do
        expected_property_value.each_with_object({}) do |argument, hash|
          hash[argument] = nil
        end
      end
    end
  end

  describe "#process" do
    subject(:process) { example_batch.process }

    let(:processor_class) { double }
    let(:processor_options) { Hash[*Faker::Lorem.words(2 * rand(1..2))].symbolize_keys }

    before do
      allow(example_batch).to receive(:processor_class).and_return(processor_class)
      allow(example_batch).to receive(:_processor_options).and_return(processor_options)
      allow(processor_class).to receive(:execute)
    end

    it "executes the processor" do
      process
      expect(processor_class).to have_received(:execute).with(example_batch, **processor_options)
    end
  end
end