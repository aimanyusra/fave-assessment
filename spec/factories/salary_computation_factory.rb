FactoryBot.define do
  salary_array = ["0", "500000"]

	factory :random_payslip, class: SalaryRecord do
    employee_name { Faker::Lorem.name }
    answer { Faker::Lorem.sentence }
    service { service_array.sample }
    number { Faker::Number.between(1, 2) }
    letter { letter.sample }
  end
end