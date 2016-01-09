Rails.application.routes.draw do
  get 'default_error' => 'errors#default_error'
  get 'validation_error' => 'errors#validation_error'
  get 'not_found' => 'errors#not_found'
  get 'permission_denied' => 'errors#permission_denied'
  get 'authentication_failed' => 'errors#authentication_failed'
  get 'need_force_update' => 'errors#need_force_update'
end
