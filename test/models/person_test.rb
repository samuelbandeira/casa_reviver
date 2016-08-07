require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @person = Person.new(name: 'Samuel Bandeira', email: 'samuelbandeira@gmail.com')
  end

  test 'should be valid' do
    assert @person.valid?
  end

  test 'name should be present' do
    @person.name = "    "
    assert_not @person.valid?
  end

  test 'name should not be more than 255 characters' do
    @person.name = "a"*256
    assert_not @person.valid?
  end

  test 'email should be nil' do
    @person.email = nil
    assert @person.valid?
  end

  test 'email should be blank' do
    @person.email = ""
    assert @person.valid?
  end

  test 'email should be with many whitespaces' do
    @person.email = "      "
    assert @person.valid?
  end

  test 'email should not be more than 255 characters' do
    @person.email = "a"*256 + "@example.com"
    assert_not @person.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @person.email = valid_address
      assert @person.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email should not accept invalid addresses' do
    invalid_addresses = %w[user@example,com USER_at_foo.COM A_US-ER@foo@bar.org
                         alice+bob@s+baz.cn]
    invalid_addresses.each do |invalid|
      @person.email = invalid
      assert_not @person.valid?, "#{invalid.inspect} should not be valid"
    end
  end

  test 'email should not accept duplicate' do
    @person.save
    personDuplicate = Person.new(name: @person.name, email: @person.email)
    assert_not personDuplicate.valid?, "email #{@person.email} must be unique"
    assert_equal ['has already been taken'], personDuplicate.errors.messages[:email]
  end

  test 'email with different cases should not accept as duplicate' do
    @person.save
    personDuplicate = Person.new(name: @person.name, email: @person.email.upcase)
    assert_not personDuplicate.valid?, "email #{@person.email} | #{personDuplicate.email} must be unique"
    assert_equal ['has already been taken'], personDuplicate.errors.messages[:email]
  end

end
