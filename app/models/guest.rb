class Guest
  def initialize(store)
    @store = store
  end

  def registered?
    false
  end

  def get_id
    cookies.has_key? :guest_id ? cookies[:guest_id] : nil
  end

  def set_id
    cookies[:guest_id] = SecureRandom.base64(64)
  end
end