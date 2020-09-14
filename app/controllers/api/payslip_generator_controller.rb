class Api::PayslipGeneratorController < ApiController
	def generate
		if payslip = PayslipGenerator.new(params[:employee_name], params[:employee_salary]).generate
			render json: payslip, status: 200
			body = JSON.parse response.body
			SalaryRecord.create(employee_name: params[:employee_name], annual_salary: params[:employee_salary], monthly_income_tax: body["monthly_income_tax"])
		else
			render json: error, status: 500
		end
	end
end