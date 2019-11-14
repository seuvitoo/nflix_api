describe "post" do
  context "when create a new user" do
    # before do
    #   new_user = build(:user).to_hash
    #   @result = ApiUser.save(new_user)
    # end

    let(:result) { ApiUser.save(build(:user).to_hash) }
    it { expect(result.response.code).to eql "200" }
  end

  context "when email is wrong" do
    let(:result) { ApiUser.save(build(:user_wrong_email).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. You entered a wrong email." }
  end

  context "when empty name" do
    let(:result) { ApiUser.save(build(:empty_name_user).to_hash) }

    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed" }
  end

  context "when empty email" do
    let(:result) { ApiUser.save(build(:empty_email_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on email failed" }
  end

  context "when empty password" do
    let(:result) { ApiUser.save(build(:empty_password_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on password failed" }
  end

  context "when has duplicate email" do
    let(:result) { ApiUser.save(build(:registered_user).to_hash) }
    it { expect(result.response.code).to eql "409" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address." }
  end

  #DESAFIO
  context "when user name is null" do
    let(:result) { ApiUser.save(build(:null_username).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.full_name cannot be null" }
  end

  context "when user email is null" do
    let(:result) { ApiUser.save(build(:null_useremail).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.email cannot be null" }
  end

  context "when user password is null" do
    let(:result) { ApiUser.save(build(:null_userpassword).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.password cannot be null" }
  end
end
