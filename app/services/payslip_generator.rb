class PayslipGenerator
	attr_reader :employee_name, :annual_salary

  def initialize(employee_name, annual_salary)
  	@employee_name = employee_name
  	@annual_salary_cents = validate_annual_salary(annual_salary)
  end

  def generate
  	calculate(@annual_salary_cents)
  end

  private

  def validate_annual_salary(annual_salary)
    raise ArgumentError, "Annual salary should not be 0" unless annual_salary != 0
    raise ArgumentError, "Annual salary is not a number" unless annual_salary.is_a? Numeric 
    raise ArgumentError, "Annual salary is not positive" unless annual_salary.to_i.positive?  
    annual_salary.to_i * 100
  end

  def calculate(annual_salary_cents)
  	gross_monthly_income = "$#{salary_to_cents(gross_monthly_income(annual_salary_cents))}"
  	monthly_income_tax = "$#{salary_to_cents(monthly_income_tax(annual_salary_cents))}"
  	net_monthly_income = "$#{salary_to_cents(net_monthly_income(annual_salary_cents))}"

	 	puts "Monthly Payslip for: #{@employee_name}"
	 	puts "Gross Monthly Income: #{gross_monthly_income}"
	  puts "Monthly Income Tax: #{monthly_income_tax}"
	  puts "Net Monthly Income: #{net_monthly_income}"

	  return @payslip = {
										  "employee_name": @employee_name,
										  "gross_monthly_income": gross_monthly_income,
										  "monthly_income_tax": monthly_income_tax,
										  "net_monthly_income": net_monthly_income
								  	}
  end

  def gross_monthly_income(annual_salary_cents)
  	(annual_salary_cents / 12).to_i / 100.0
  end

  def monthly_income_tax(annual_salary_cents)
  	brackets = [
			{
				min_treshold_cents: 0,
				tax_rate: 0
			},
			{
				min_treshold_cents: 2000100,
				tax_rate: 0.1
			},
			{
				min_treshold_cents: 4000100,
				tax_rate: 0.2
			},
			{
				min_treshold_cents: 8000100,
				tax_rate: 0.3
			},
			{
				min_treshold_cents: 18000100,
				tax_rate: 0.4
			}
		]

	  total_tax = 0
    
		brackets.reverse.each do |bracket|
			if annual_salary_cents >= bracket[:min_treshold_cents]
				portion = annual_salary_cents - bracket[:min_treshold_cents]
				total_tax += bracket[:tax_rate] * portion
				annual_salary_cents -= portion
			end
		end
		monthly_tax = total_tax / 12 / 100.0 #convert to monthly and dollars
  end

  def net_monthly_income(annual_salary_cents)
  	((gross_monthly_income(annual_salary_cents).to_f - monthly_income_tax(annual_salary_cents).to_f))
  end

  def salary_to_cents(amount)
    '%.2f' % amount.round
  end
end