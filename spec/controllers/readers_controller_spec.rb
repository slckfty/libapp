require 'spec_helper'

describe ReadersController do
  describe "GET new" do
    let!(:reader) {mock_model("Reader").as_new_record}

    before :each do
      Reader.stub(:new).and_return(reader)
    end

    it "assigns @reader variable to the view" do
      get :new
      expect(assigns[:reader]).to eq(reader)
    end
    it "renders new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let!(:reader) { stub_model(Reader) }
    params = {
        "email" => "email@email.com",
        "password" => "pass",
        "password_confirmation" => "pass"
    }
    before :each do
      Reader.stub(:new).and_return(reader)
    end
    it "sends new message to Reader class" do
      reader.stub(:save).and_return(true)
      Reader.should_receive(:new).with(params)
      post :create, reader: params
    end
    it "sends save message to reader model" do
      reader.should_receive(:save)
      post :create
    end
    context "when save message returns true" do
      before :each do
        reader.stub(:save).and_return(true)
        post :create, reader: params
      end
      it "redirects to root url" do
        expect(response).to redirect_to root_url
      end
      it "assigns a success flash message" do
        expect(flash[:notice]).not_to be_nil
      end
      it "it logs in reader" do
        expect(session[:reader_id]).to eq(reader.id)
      end
    end
    context "when save message returns false" do
      before :each do
        reader.stub(:save).and_return(false)
        post :create, reader: params
      end
      it "renders new template" do
        expect(response).to render_template :new
      end
      it "assigns reader variable to the view" do
        expect(assigns[:reader]).to eq(reader)
      end
      it "assigns error flash message" do
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end