shared_examples_for '400 Bad Request' do
  it '400 Bad Request' do
    expect(response).not_to be_success
    expect(response.status).to eq 400
  end
end

shared_examples_for '401 Unauthorized' do
  it '401 Unauthorized' do
    expect(response).not_to be_success
    expect(response.status).to eq 401
  end
end

shared_examples_for '403 Forbidden' do
  it '403 Forbidden' do
    expect(response).not_to be_success
    expect(response.status).to eq 403
  end
end

shared_examples_for '404 Not Found' do
  it '404 Not Found' do
    expect(response).not_to be_success
    expect(response.status).to eq 404
  end
end

shared_examples_for '409 Conflict' do
  it '409 Conflict' do
    expect(response).not_to be_success
    expect(response.status).to eq 409
  end
end

shared_examples_for '410 Gone' do
  it '410 Gone' do
    expect(response).not_to be_success
    expect(response.status).to eq 410
  end
end
