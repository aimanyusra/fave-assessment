class Api::PayslipGeneratorController < ApiController
	def create
		render json: PayslipGenerator.new(params[:employee_name], params[:employee_salary]).generate, status: 200

		if status == 200
			body = JSON.parse response.body
			SalaryRecord.create(employee_name: params[:employee_name], annual_salary: params[:employee_salary], monthly_income_tax: body["monthly_income_tax"])
		end
	end
end