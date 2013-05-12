# CSH::SeminarConverter

This quickie Dancer-based perl webapp listens for git webhook calls and 
converts all of the seminar files to ppt, odp and pdf.

## Support more formats!

Ok. Tell me what you want.

## How does this work?

Poorly, really. I just `git clone` the repo and call out to `unoconv` to do 
the conversion.
