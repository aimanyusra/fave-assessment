require 'rails_helper'

RSpec.describe Api::PayslipGeneratorController do
  describe "GET #index" do
    before do
      get '/api/payslip_generator'
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected recipe attributes" do
      res = JSON.parse(response.body)
      byebug
      expect(res.keys).to match_array(["salary_computations"])
    end
  end
end

# describe "post payslip generator route success", :type => :request do
#   before do
#     post '/api/payslip_generator', params: { employee_name: 'Ren', employee_salary: 60000 }
#   end

#   it 'returns the employee name' do
#     expect(JSON.parse(response.body)['employee_name']).to eq('Ren')
#   end
#   it 'returns the employee\'s gross monthly income' do
#     expect(JSON.parse(response.body)['gross_monthly_income']).to eq('$5000.00')
#   end
#   it 'returns the employee\'s monthly income tax' do
#     expect(JSON.parse(response.body)['monthly_income_tax']).to eq('$500.00')
#   end
#   it 'returns the employee\'s net monthly income' do
#     expect(JSON.parse(response.body)['net_monthly_income']).to eq('$4500.00')
#   end
#   it 'returns HTTP success code' do
#     expect(response.status).to eq(200)
#   end
# end


