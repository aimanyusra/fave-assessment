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
		p "Monthly Payslip for: #{@employee_name}"
		p "Gross Monthly Income: $#{'%2.f' % gross_monthly_income(annual_salary_cents)}" 
	 	p "Monthly Income Tax: $#{'%2.f' % monthly_income_tax(annual_salary_cents)}"
	 	# p "Net Monthly Income: $#{'%2.f' % net_monthly_income(annual_salary_cents)}"
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
				p total_tax
			end
		end
		monthly_tax = total_tax / 12.0 / 100.0 #convert to monthly and dollars


		# if annual_salary_cents <= tier_one_cents
		# 	0
		# elsif annual_salary_cents <= tier_two_cents
		# 	gross_monthly_income(annual_salary_cents).to_f * 0.1
		# elsif annual_salary_cents <= tier_three_cents
		# 	annual_tax_cents = ((tier_two_cents - tier_one_cents) * 0.1) + ((annual_salary_cents - tier_two_cents) * 0.2)
		# 	annual_tax_cents / 100 / 12 #convert to month and dollars
		# elsif annual_salary_cents <= tier_four_cents
		# 	annual_tax_cents = ((tier_two_cents - tier_one_cents) * 0.1) + ((tier_three_cents - tier_two_cents) * 0.2) + 
		# 												((annual_salary_cents - tier_three_cents) * 0.3)
		# 	annual_tax_cents / 100 / 12
		# elsif annual_salary_cents > tier_four_cents
		# 	annual_tax_cents = ((tier_two_cents - tier_one_cents) * 0.1) + ((tier_three_cents - tier_two_cents) * 0.2) + 
		# 												((tier_four_cents - tier_three_cents) * 0.3) + ((annual_salary_cents - tier_four_cents) * 0.4)
		# 	annual_tax_cents / 100 / 12
		# else
		# 	'Not a valid number'
		# end
  end

  def net_monthly_income(annual_salary_cents)
  	'%.2f' % (gross_monthly_income(annual_salary_cents).to_f - monthly_income_tax(annual_salary_cents).to_f)
  end
end