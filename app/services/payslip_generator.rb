class PayslipGenerator
	attr_reader :employee_name, :annual_salary

  def initialize(employee_name, annual_salary)
  	@employee_name = employee_name
  	@annual_salary_cents = annual_salary.to_i * 100
  end

  def generate
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
		p "Gross Monthly Income: $#{gross_monthly_income(annual_salary_cents)}" 
	 	p "Monthly Income Tax: $#{monthly_income_tax(annual_salary_cents)}"
	 	p "Net Monthly Income: $#{net_monthly_income(annual_salary_cents)}"
  end

  def gross_monthly_income(annual_salary_cents)
  	return '%.2f' % ((annual_salary_cents / 12).to_i / 100.0)
  end

  def monthly_income_tax(annual_salary_cents)
  	case annual_salary_cents
  	when 0..2000000
  		return 0 * gross_monthly_income(annual_salary_cents).to_f
  	when 2000100..4000000
  		return '%.2f' % (gross_monthly_income(annual_salary_cents).to_f * 10 / 100)
  	when 4000100..8000000
  		return '%.2f' % (gross_monthly_income(annual_salary_cents).to_f * 20 / 100)
  	when 8000100..18000000
  		return '%.2f' % (gross_monthly_income(annual_salary_cents).to_f * 30 / 100)
  	else
  		if annual_salary_cents >= 18000100
  			return '%.2f' % (gross_monthly_income(annual_salary_cents).to_f * 40 / 100)
  		else
  			return "Not a valid number"
  		end
		end
  end

  def net_monthly_income(annual_salary_cents)
  	'%.2f' % (gross_monthly_income(annual_salary_cents).to_f - monthly_income_tax(annual_salary_cents).to_f)
  end
end