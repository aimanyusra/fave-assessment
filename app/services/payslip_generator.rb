class PayslipGenerator
	attr_reader :employee_name, :annual_salary

  def initialize(employee_name, annual_salary)
  	@employee_name = employee_name
  	@annual_salary_cents = annual_salary.to_i * 100
  end

  def generate
  	return "Please input a valid amount" if @annual_salary_cents.negative?
  	calculate(@annual_salary_cents)
  end

  private

  def calculate(annual_salary_cents)
	 	puts "Monthly Payslip for: #{@employee_name}"
	 	puts "Gross Monthly Income: $#{'%.2f' % gross_monthly_income(annual_salary_cents)}" 
	  puts "Monthly Income Tax: $#{'%.2f' % monthly_income_tax(annual_salary_cents).round}"
	  puts "Net Monthly Income: $#{'%.2f' % net_monthly_income(annual_salary_cents)}"
  end

  def gross_monthly_income(annual_salary_cents)
  	return (annual_salary_cents / 12).to_i / 100.0
  end

  def monthly_income_tax(annual_salary_cents)
  	brackets = [
  								{
  									min_treshold: 0,
  									max_treshold: 2000000,
  									tax: 0
									},
									{
  									min_treshold: 2000100,
  									max_treshold: 4000000,
  									tax: 0.1
									},
									{
  									min_treshold: 4000100,
  									max_treshold: 8000000,
  									tax: 0.2
									},
									{
  									min_treshold: 8000100,
  									max_treshold: 18000000,
  									tax: 0.3
									},
									{
  									min_treshold: 18000100,
  									max_treshold: 18000100..,
  									tax: 0.4
									},
								]

	  total_tax = 0
    
		brackets.reverse.each do |bracket|
			if annual_salary_cents >= bracket[:min_treshold]
				portion = annual_salary_cents - bracket[:min_treshold]
				total_tax += bracket[:tax] * portion
				annual_salary_cents -= portion
			end
		end
		monthly_tax = total_tax / 12 / 100.0 #convert to monthly and dollars
  end

  def net_monthly_income(annual_salary_cents)
  	'%.2f' % ((gross_monthly_income(annual_salary_cents).to_f - monthly_income_tax(annual_salary_cents).to_f)).round
  end
end