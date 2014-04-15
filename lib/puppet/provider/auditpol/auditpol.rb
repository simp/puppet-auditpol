Puppet::Type.type(:auditpol).provide(:auditpol) do

  confine :osfamily => :windows
  defaultfor :osfamily => :windows

  commands :auditpol => 'auditpol.exe'

  def success
    @property_hash[:success]
  end

  def success=(value)
    subcategory_name = resource[:subcategory]
    auditpol('/set', "/subcategory:#{subcategory_name}", "/success:#{resource[:success]}")
  end

  def failure
    @property_hash[:failure]
  end

  def failure=(value)
    subcategory_name = resource[:subcategory]
    auditpol('/set', "/subcategory:#{subcategory_name}", "/failure:#{resource[:failure]}")
  end

  def self.instances
    # generate a list of all categories and subcategories in csv
    categories = auditpol('/get', '/category:*', '/r')

    # the drop(1) drops the header line
    categories.split("\n").drop(1).collect do |line|

      line_array = line.split(',')
      subcategory_name = line_array[2]
      subcategory_policy = line_array[4]

      case subcategory_policy
      when 'Success'
        success = 'enable'
        failure = 'disable'
      when 'Failure'
        success = 'disable'
        failure = 'enable'
      when 'Success and Failure'
        success = 'enable'
        failure = 'enable'
      when 'No Auditing'
        success = 'disable'
        failure = 'disable'
      else # disable all if something weird happened I guess
        success = 'disable'
        failure = 'disable'
      end

      new(:name => subcategory_name,
          :success => success,
          :failure => failure)
    end
  end

  def self.prefetch(resources)
    policies = instances
    resources.keys.each do |name|
      if provider = policies.find { |policy| policy.name == name }
        resources[name].provider = provider
      end
    end
  end

end
