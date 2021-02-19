module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email',    with: @work.user.email
    fill_in 'Password', with: @work.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end