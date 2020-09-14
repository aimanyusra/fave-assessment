class Api::PayslipGeneratorController < ApiController
	def generate
		render json: PayslipGenerator.new(params[:employee_name], params[:employee_salary]).generate
	end
end