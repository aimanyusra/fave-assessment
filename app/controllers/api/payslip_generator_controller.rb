class Api::PayslipGeneratorController < ApiController
	def create

		render json: PayslipGenerator.new(params[:employee_name], params[:employee_salary]).generate
	end
end