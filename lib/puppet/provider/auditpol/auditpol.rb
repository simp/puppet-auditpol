Puppet::Type.type(:auditpol).provide(:auditpol) do

  confine :osfamily => :windows
  defaultfor :osfamily => :windows

  commands :auditpol => 'auditpol.exe'

  def success
    subcategory_name = resource[:subcategory]
    if auditpol('/get', "/subcategory:#{subcategory_name}") =~ /Success/
      :enable
    else
      :disable
    end
  end

  def success=(value)
    subcategory_name = resource[:subcategory]
    auditpol('/set', "/subcategory:#{subcategory_name}", "/success:#{resource[:success]}")
  end

  def failure
    subcategory_name = resource[:subcategory]
    if auditpol('/get', "/subcategory:#{subcategory_name}") =~ /Failure/
      :enable
    else
      :disable
    end
  end

  def failure=(value)
    subcategory_name = resource[:subcategory]
    auditpol('/set', "/subcategory:#{subcategory_name}", "/failure:#{resource[:failure]}")
  end

end
