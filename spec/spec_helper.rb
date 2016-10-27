require 'build_pack'
require 'pry'
require 'webmock/rspec'

RSpec.configure do |config|
end

SAMPLE_DEBIAN_RESPONSE =
%{
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_ia64.deb">mysql-client-5.5_5.5.47-0+deb7u1_ia64.deb</a></td><td align="right">2016-01-27 20:58  </td><td align="right">2.0M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_kfreebsd-amd64.deb">mysql-client-5.5_5.5.47-0+deb7u1_kfreebsd-amd64.deb</a></td><td align="right">2016-01-27 19:38  </td><td align="right">1.6M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_kfreebsd-i386.deb">mysql-client-5.5_5.5.47-0+deb7u1_kfreebsd-i386.deb</a></td><td align="right">2016-01-27 17:58  </td><td align="right">1.5M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_mips.deb">mysql-client-5.5_5.5.47-0+deb7u1_mips.deb</a></td><td align="right">2016-01-27 22:28  </td><td align="right">1.5M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_mipsel.deb">mysql-client-5.5_5.5.47-0+deb7u1_mipsel.deb</a></td><td align="right">2016-01-27 22:28  </td><td align="right">1.5M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_powerpc.deb">mysql-client-5.5_5.5.47-0+deb7u1_powerpc.deb</a></td><td align="right">2016-01-27 18:28  </td><td align="right">1.3M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_s390.deb">mysql-client-5.5_5.5.47-0+deb7u1_s390.deb</a></td><td align="right">2016-01-27 18:13  </td><td align="right">1.6M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.51-0+deb8u1_amd64.deb">mysql-client-5.5_5.5.51-0+deb8u1_amd64.deb</a></td><td align="right">2016-09-14 06:11  </td><td align="right">1.6M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_s390x.deb">mysql-client-5.5_5.5.47-0+deb7u1_s390x.deb</a></td><td align="right">2016-01-27 18:43  </td><td align="right">1.6M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.47-0+deb7u1_sparc.deb">mysql-client-5.5_5.5.47-0+deb7u1_sparc.deb</a></td><td align="right">2016-01-27 23:28  </td><td align="right">1.4M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.62-0+deb7u1_amd64.deb">mysql-client-5.5_5.5.62-0+deb7u1_amd64.deb</a></td><td align="right">2016-09-16 15:07  </td><td align="right">1.7M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb7u1_armel.deb">mysql-client-5.5_5.5.52-0+deb7u1_armel.deb</a></td><td align="right">2016-09-16 18:27  </td><td align="right">1.4M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb7u1_armhf.deb">mysql-client-5.5_5.5.52-0+deb7u1_armhf.deb</a></td><td align="right">2016-09-16 18:27  </td><td align="right">1.4M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb7u1_i386.deb">mysql-client-5.5_5.5.52-0+deb7u1_i386.deb</a></td><td align="right">2016-09-16 16:57  </td><td align="right">1.5M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.50-0+deb8u1_amd64.deb">mysql-client-5.5_5.5.50-0+deb8u1_amd64.deb</a></td><td align="right">2016-09-14 06:11  </td><td align="right">1.6M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb8u1_arm64.deb">mysql-client-5.5_5.5.52-0+deb8u1_arm64.deb</a></td><td align="right">2016-09-14 06:26  </td><td align="right">1.4M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb8u1_armel.deb">mysql-client-5.5_5.5.52-0+deb8u1_armel.deb</a></td><td align="right">2016-09-14 07:26  </td><td align="right">1.4M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb8u1_armhf.deb">mysql-client-5.5_5.5.52-0+deb8u1_armhf.deb</a></td><td align="right">2016-09-16 15:57  </td><td align="right">1.4M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb8u1_i386.deb">mysql-client-5.5_5.5.52-0+deb8u1_i386.deb</a></td><td align="right">2016-09-14 05:56  </td><td align="right">1.6M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb8u1_kfreebsd-amd64.deb">mysql-client-5.5_5.5.52-0+deb8u1_kfreebsd-amd64.deb</a></td><td align="right">2016-09-14 16:57  </td><td align="right">1.5M</td></tr>
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="mysql-client-5.5_5.5.52-0+deb8u1_kfreebsd-i386.deb">mysql-client-5.5_5.5.52-0+deb8u1_kfreebsd-i386.deb</a></td><td align="right">2016-09-14 17:12  </td><td align="right">1.6M</td></tr>
}
