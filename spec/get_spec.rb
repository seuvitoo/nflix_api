describe "get" do
  context "when a registered user" do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, user.id) }
    let(:user_data) { Database.new.find_user(user.email) }

    it { expect(result.response.code).to eql "200" }
    it { expect(result.parsed_response["full_name"]).to eql user_data["full_name"] }
  end
end
