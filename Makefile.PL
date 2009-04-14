require 5.6.0;
use ExtUtils::MakeMaker;
WriteMakefile
(
          'PL_FILES' => {},
          'INSTALLDIRS' => 'site',
          'NAME' => 'WWW::Shorten::Digg',
          'VERSION_FROM' => 'lib/WWW/Shorten/Digg.pm',
          'PREREQ_PM' => {
          	               'WWW::Shorten' => '1.98',
                           'URI::Escape' => 0,
                           'HTML::Entities' => 0,
                         }
        )
;
