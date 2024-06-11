require "rails_helper"

RSpec.describe "Users API", type: :request do
  describe "POST /api/v1/users" do
    it "happy path - creates a new user" do
      post(
        "/api/v1/users",
        params: {
          name: "test",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        }.to_json,
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )
      expect(response).to have_http_status(201)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:type]).to eq("user")
      expect(body[:data][:attributes]).to be_a(Hash)

      expect(body[:data][:attributes]).to have_key(:name)
      expect(body[:data][:attributes][:name]).to be_a(String)

      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes][:email]).to be_a(String)

      expect(body[:data][:attributes]).to have_key(:api_key)
      expect(body[:data][:attributes][:api_key]).to be_a(String)
    end

    it "sad path - not unique email" do
      User.create(
        name: "test",
        email: "test@test.com",
        password: "password",
        api_key: SecureRandom.hex(13)
      )

      post(
        "/api/v1/users",
        params: {
          name: "test",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        }.to_json,
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )

      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Email has already been taken")
    end

    it "sad path - password confirmation does not match" do
      post(
        "/api/v1/users",
        params: {
          name: "test",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password1"
        }.to_json,
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )

      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Password confirmation doesn't match Password")
    end
  end

  describe "POST /api/v1/sessions" do
    it "happy path - logs in a user" do
      user = User.create(
        name: "test",
        email: "test@test.com",
        password: "password",
        api_key: SecureRandom.hex(13)
      )

      post(
        "/api/v1/sessions",
        params: {
          email: "test@test.com",
          password: "password"
        }.to_json,
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )

      expect(response).to have_http_status(201)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:type]).to eq("user")
      expect(body[:data][:attributes]).to be_a(Hash)

      expect(body[:data][:attributes]).to have_key(:name)
      expect(body[:data][:attributes][:name]).to be_a(String)

      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes][:email]).to be_a(String)

      expect(body[:data][:attributes]).to have_key(:api_key)
      expect(body[:data][:attributes][:api_key]).to be_a(String)
    end

    it "sad path - bad credentials (bad email)" do
      user = User.create(
        name: "test",
        email: "test@test.com",
        password: "password",
        api_key: SecureRandom.hex(13)
      )

      post(
        "/api/v1/sessions",
        params: {
          email: "wrong@test.com",
          password: "password"
        }.to_json,
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )

      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Sorry, your credentials are bad.")
    end

    it "sad path - bad credentials (bad password)" do
      user = User.create(
        name: "test",
        email: "test@test.com",
        password: "password",
        api_key: SecureRandom.hex(13)
      )

      post(
        "/api/v1/sessions",
        params: {
          email: "test@test.com",
          password: "wrong_password"
        }.to_json,
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )

      expect(response).to have_http_status(400)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:errors)
      expect(body[:errors]).to eq("Sorry, your credentials are bad.")
    end
  end
end
