class Plan
  #const plans variable
  PLANS = [:free, :premium]
  
  #ouput [['FREE', 'free'], ['PREMIUM', 'premium']]
  #milia has no idea tenant is going to use plan since milia only deals with tenant
  #so we need to whitelist (in milia's config) this plan attribute for milia to handle it too
  def self.options
    PLANS.map { |plan| [plan.capitalize, plan] }
  end
end