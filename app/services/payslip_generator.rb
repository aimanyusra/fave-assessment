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
  	# tier_one = 0%
  	# tier_two = 10%
  	# tier_three = 20%
  	# tier_four = 30%
  	# tier_five = 40%

		p "Monthly Payslip for: #{@employee_name}"
		p "Gross Monthly Income: $#{'%2.f' % gross_monthly_income(annual_salary_cents)}" 
	 	p "Monthly Income Tax: $#{'%2.f' % monthly_income_tax(annual_salary_cents)}"
	 	p "Net Monthly Income: $#{'%2.f' % net_monthly_income(annual_salary_cents)}"
  end

  def gross_monthly_income(annual_salary_cents)
  	return (annual_salary_cents / 12).to_i / 100.0
  end

  def monthly_income_tax(annual_salary_cents)
		tier_one_cents = 2000000
		tier_two_cents = 4000000
		tier_three_cents = 8000000
		tier_four_cents = 18000000

		if annual_salary_cents <= tier_one_cents
			0
		elsif annual_salary_cents <= tier_two_cents
			gross_monthly_income(annual_salary_cents).to_f * 0.1
		elsif annual_salary_cents <= tier_three_cents
			annual_tax_cents = ((tier_two_cents - tier_one_cents) * 0.1) + ((annual_salary_cents - tier_two_cents) * 0.2)
			annual_tax_cents / 100 / 12 #convert to month and dollars
		elsif annual_salary_cents <= tier_four_cents
			annual_tax_cents = ((tier_two_cents - tier_one_cents) * 0.1) + ((tier_three_cents - tier_two_cents) * 0.2) + 
														((annual_salary_cents - tier_three_cents) * 0.3)
			annual_tax_cents / 100 / 12
		elsif annual_salary_cents > tier_four_cents
			annual_tax_cents = ((tier_two_cents - tier_one_cents) * 0.1) + ((tier_three_cents - tier_two_cents) * 0.2) + 
														((tier_four_cents - tier_three_cents) * 0.3) + ((annual_salary_cents - tier_four_cents) * 0.4)
			annual_tax_cents / 100 / 12
		else
			'Not a valid number'
		end
  end

  def net_monthly_income(annual_salary_cents)
  	'%.2f' % (gross_monthly_income(annual_salary_cents).to_f - monthly_income_tax(annual_salary_cents).to_f)
  end
end