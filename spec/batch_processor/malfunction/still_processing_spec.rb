# frozen_string_literal: true

RSpec.describe BatchProcessor::Malfunction::StillProcessing, type: :malfunction do
  subject(:malfunction) { described_class.new }

  it { is_expected.to inherit_from BatchProcessor::Malfunction::Base }

  it { is_expected.to have_prototype_name "StillProcessing" }
  it { is_expected.to conjugate_into BatchProcessor::StillProcessingError }

  it { is_expected.not_to use_attribute_errors }
  it { is_expected.not_to be_contextualized }
  it { is_expected.to have_default_problem }
end
