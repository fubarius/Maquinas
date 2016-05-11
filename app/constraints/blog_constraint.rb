class BlogConstraint
  BLACKLIST = %w(www admin help about)

  def matches?(request)
    request.subdomain && BLACKLIST.exclude?(request.subdomain)
  end
end
