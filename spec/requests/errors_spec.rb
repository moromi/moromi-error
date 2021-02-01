describe 'Error Renderer' do
  before do
    get path
  end

  describe 'Default' do
    let(:path) { '/default_error.json' }

    include_examples '500 Internal Server Error'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::Default::DEFAULT_CODE
      expect(json['errors']).not_to be_empty
    end
  end

  describe 'ValidationError' do
    let(:path) { '/validation_error.json' }

    include_examples '400 Bad Request'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::ValidationError::DEFAULT_CODE
      expect(json['errors']).not_to be_empty
    end
  end

  describe 'NotFound' do
    let(:path) { '/not_found.json' }

    include_examples '404 Not Found'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::NotFound::DEFAULT_CODE
      expect(json['errors']).not_to be_empty
    end
  end

  describe 'PermissionDenied' do
    let(:path) { '/permission_denied.json' }

    include_examples '403 Forbidden'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::PermissionDenied::DEFAULT_CODE
      expect(json['errors']).not_to be_empty
    end
  end

  describe 'AuthenticationFailed' do
    let(:path) { '/authentication_failed.json' }

    include_examples '401 Unauthorized'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::AuthenticationFailed::DEFAULT_CODE
      expect(json['errors']).not_to be_empty
    end
  end

  describe 'NeedForceUpdate' do
    let(:path) { '/need_force_update.json' }

    include_examples '400 Bad Request'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::NeedForceUpdate::DEFAULT_CODE
      expect(json['detail_url']).to eq 'https://example.com'
      expect(json['errors']).not_to be_empty
    end
  end

  describe 'TooManyRequests' do
    let(:path) { '/too_many_requests.json' }

    include_examples '429 Too Many Requests'

    it 'returns error json' do
      json = JSON.parse(response.body)
      expect(json['code']).to eq Moromi::Error::TooManyRequests::DEFAULT_CODE
      expect(json['errors']).not_to be_empty
    end
  end
end
