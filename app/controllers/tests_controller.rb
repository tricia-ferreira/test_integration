class TestsController < ApplicationController
  before_action :set_response_variables, only: [:create, :results]

  def index; end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save
        @response = create_invite
        if @response.present?
          format.html { render :show, notice: 'Test was successfully created.' }
        else
          format.html { render :new, alert: 'Could not create invitation.' }
        end
      else
        format.html { render :new }
      end
    end
  end

  def show
    @test = Test.find(params[:id])
  end

  def callback
    return unless request.headers['Content-Type'] == 'application/json'
    data = JSON.parse(request.body)
    puts "Result: #{data}"
    render nothing: true
  end

  private

  def test_params
    params.require(:test).permit(
      :id, :test_id, :first_name
    )
  end

  def set_response_variables
    @url = 'https://codility.com/api/tests/87436/invite/'
    @auth_token = 'Bearer O4r7pshQuozmjO1Hkvhl'
  end

  def create_invite
    response = RestClient.post @url, { candidates: candidate_params }.to_json, { Authorization: @auth_token }
    JSON.parse(response) if response.code == 200
  end

  def candidate_params
    [{
      id: test_params[:test_id],
      first_name: test_params[:first_name]
    }]
  end
end
