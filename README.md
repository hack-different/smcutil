# `smcutil` for Appple SMC

`smcutil` is a command line tool for reading Apple's SMC payloads on T1 and prior devices, validating them, fingerprinting them and extracting the contents for disassembly.

## Progress

Currently looking for a number of MacBooks with good SMCs that may be offered as tribute for `save`
and waiting on Stellaris development hardware.  Anyone have a sub-micron wealder out there?

## Installation

Install it yourself as:

    $ gem install smcutil

## Usage

    $ smcutil
      
    Usage: smcutil {command} [PARAMS]
        
    Command is one of:
        
      validate {file.smc}:
        Causes smcutil to parse the Apple SMC file and validate correctness.
         
      info {file.smc}:
        Prints information about the SMC update file.
        
      decode {file.smc} {output.bin}:
        Pretends to execute an update of the SMC flash as though the output.bin file is the SMC flash ROM.
        
      shred {file.smc} {output_dir}:
        Pulls apart each flash region, so that multiple passes can be examined
        
      save {output.bin}:
        (IN PROGRESS)
        Has magical bear powers.  Loads SMC update payload to capture the contents of the application partition.
        No warrently, may bork hardware.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rickmark/smcutil. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SmcUtil project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rickmark/smcutil/blob/master/CODE_OF_CONDUCT.md).
