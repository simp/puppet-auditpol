Puppet::Type.newtype(:auditpol) do

  desc 'auditpol type for windows'

  newparam(:subcategory, :namevar => true) do
    desc 'The subcategory of the policy.'
  end

  newproperty(:success) do
    desc 'Whether auditing is enabled on success or not'
    newvalues(:enable, :disable)
  end

  newproperty(:failure) do
    desc 'Whether auditing is enabled on failure or not'
    newvalues(:enable, :disable)
  end

end
