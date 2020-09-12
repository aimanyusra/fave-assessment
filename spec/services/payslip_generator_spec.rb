require 'rails_helper'

RSpec.describe PayslipGenerator do
  describe '#generate' do
    it 'prints error message' do
      PayslipGenerator.new('Ren', -1).generate.should eq("Please input a valid amount")
    end

    it 'prints employee payslip' do
      expect do
				PayslipGenerator.new('Ren', 60000).generate
      end.to output("Monthly Payslip for: Ren\nGross Monthly Income: $5000\nMonthly Income Tax: $500\nNet Monthly Income: $4500\n").to_stdout
    end
  end
end