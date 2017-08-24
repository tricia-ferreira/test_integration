require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  let(:url) { 'https://codility.com/api/tests/87436/invite/' }
  let(:build_test) { build(:test) }

  describe 'GET#index' do
    context 'format html' do
      subject { get :index }
      before { subject }

      it 'returns a 200 status' do
        expect(response.status).to eq 200
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET#new' do
    subject { get :new }
    before { subject }

    it 'renders the :new template' do
      expect(response).to render_template :new
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end

    it 'builds new test' do
      expect(assigns(:test)).to be_a_new(Test)
    end
  end

  describe 'POST#create' do

    context 'valid attributes' do
      before :each do
        stub_request(:post, url).
           with(body: "{\"candidates\":[{\"id\":\"1\",\"first_name\":\"MyString\"}]}",
                headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer O4r7pshQuozmjO1Hkvhl', 'Content-Length'=>'51', 'Host'=>'codility.com', 'User-Agent'=>'rest-client/2.0.2 (darwin16.0.0 x86_64) ruby/2.3.1p112'}).
           to_return(status: 200, body: { candidates: [{ id: 1 }] }.to_json, headers: {})
      end
      subject { post :create, params: { test: build_test.attributes } }
      before { subject }

      it 'post to codility' do
        expect(a_request(:post, "https://codility.com/api/tests/87436/invite/"))
          .to have_been_made.once
      end

      it 'renders show template' do
        expect(response).to render_template :show
      end

      it 'creates test' do
        expect(assigns(:test).persisted?).to eq true
      end

      it 'assigns response' do
        expect(assigns(:response).present?).to eq true
      end
    end

    context 'invalid response' do
      before :each do
        stub_request(:post, url).
           with(body: "{\"candidates\":[{\"id\":\"1\",\"first_name\":\"MyString\"}]}",
                headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer O4r7pshQuozmjO1Hkvhl', 'Content-Length'=>'51', 'Host'=>'codility.com', 'User-Agent'=>'rest-client/2.0.2 (darwin16.0.0 x86_64) ruby/2.3.1p112'}).
           to_return(status: 200, body: "{}", headers: {})
      end

      subject { post :create, params: { test: build_test.attributes } }
      before { subject }

      it 'post to codility' do
        expect(a_request(:post, "https://codility.com/api/tests/87436/invite/"))
          .to have_been_made.once
      end

      it 'renders show template' do
        expect(response).to render_template :new
      end

      it 'creates test' do
        expect(assigns(:test).persisted?).to eq true
      end
    end

    context 'invalid attributes' do
      subject { post :create, params: { test: { test_id: build_test.test_id } } }
      before { subject }

      it 'renders show template' do
        expect(response).to render_template :new
      end

      it 'does not create test' do
        expect(assigns(:test).persisted?).to eq false
      end
    end
  end
end
