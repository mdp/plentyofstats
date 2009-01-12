results = "blah Results 0 to 20 out of 298 results are shown below. and then some"

results =~ /Results \d+ to \d+ out of (\d+) results are shown below/
p $1