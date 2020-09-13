require 'rails_helper'

RSpec.describe PayslipGenerator do
  describe '#generate' do
    it 'prints error message if input is negative' do
      expect do
        PayslipGenerator.new('Ren', -1).generate
      end.to raise_error(ArgumentError, "Annual salary is not positive")
    end

    it 'prints error message if input is not a number' do
      expect do
        PayslipGenerator.new('Ren', "abc").generate
      end.to raise_error(ArgumentError, "Annual salary is not a number")
    end

    it 'prints error message if input is 0' do
      expect do
        PayslipGenerator.new('Ren', 0).generate
      end.to raise_error(ArgumentError, "Annual salary should not be 0")
    end

    it 'prints employee payslip' do
      expect do
        PayslipGenerator.new('Ren', 60000).generate
      end.to output("Monthly Payslip for: Ren\nGross Monthly Income: $5000.00\nMonthly Income Tax: $500.00\nNet Monthly Income: $4500.00\n").to_stdout
    end
  end
end