class Api::PayslipGeneratorController < ApiController
	def index
		salary_computations = []
		SalaryRecord.all.each do |record|
			obj = {
				time_stamp: record.created_at.to_i.to_s,
				employee_name: record.employee_name,
				annual_salary: record.annual_salary,
				monthly_income_tax: record.monthly_income_tax
			}

			salary_computations << obj
		end

		render json: { salary_computations: salary_computations }
	end


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