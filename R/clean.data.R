## Data frame setup, data cleaning, general wrangling

# Use dplyr to select only the fields we need
dat <- full.data %>%
  select(Entity.ID, Entity.Record.Status.Desc, Booth.ClassYr.or.RecYr, Booth.Program,
         Booth.Program.Group, Entity.Degreed.Alum.Undergrad.Ind, Entity.Ever.FacStaff.Ind,
         Entity.Parent.Ind, Bus.Title.High.Lvl, Employ.Years.At.Current.Company,
         Pref.Addr.State.Cd, Pref.Addr.Country.Desc, Gift.Capacity.Numerical.Amt..CR.,
         Research.Capacity, Research.Non.Capacity, Booth.Lifetime.Giving, Giving.FYs.of.Giving,
         Giving.FY.in.Last.5, Giving.Booth.Allocations.Supported, Giving.Booth.Gifts.Count,
         Giving.Booth.AF.Gifts, Giving.Ever.Pledged.to.Booth, Gift.Donor.Flag..25k,
         Giving.AF.Scholarship, Giving.Student.Support, Giving.First.Trans.Dt, Giving.First.Trans.Amt,
         Spouse.Married.UC.Booth, Rel.Known.Tos.Count, Action.Visit.Count..BUS.,
         Action.NonVisit.Count..BUS., Committees..BUS., Committee.in.Last.3.FY, Committee.Reunion.Active,
         Vol.Acts..BUS., Vol.Acts.Event.Speaker, Events.Vol.Speaker, Vol.Acts.Was.Club.President,
         Vol.Act.Student.Supporter, Alloc.Stewardee.Student.Support, Student.Acts..BUS.,
         Student.Acts..BUS..Leader, Scholarships.Count, Awards..BUS., Events.Attended..BUS.,
         Events.Attended..BUS..Reunion, Events.Attended..BUS..Student, Events.Attended.in.Last.3.FY..BUS.,
         Nonprofit.Leadership.Flag, Non.UChicago.Notable.Vol.Flag, In.Magazine) %>%
  # Create the response variable
  mutate(Gift.Donor.Flag..25k = ifelse(Gift.Donor.Flag..25k == "Y", 1, 0)) %>%
  # Remove any duplicate records, and any non-alumni records
  filter(Entity.Record.Status.Desc != "Purgable",
         Booth.Program.Group != "") %>%
  # Create factors as needed
  mutate_at(vars(Entity.Record.Status.Desc, Booth.Program, Booth.Program.Group,
                 Entity.Degreed.Alum.Undergrad.Ind, Entity.Ever.FacStaff.Ind, Entity.Parent.Ind,
                 Pref.Addr.State.Cd, Pref.Addr.Country.Desc, Giving.Ever.Pledged.to.Booth,
                 Spouse.Married.UC.Booth, Non.UChicago.Notable.Vol.Flag, In.Magazine),
            as.factor) %>%
  # Drop unused factor levels
  droplevels() %>%
  # Convert currency to numeric as needed
  mutate_at(vars(Gift.Capacity.Numerical.Amt..CR., Booth.Lifetime.Giving, Giving.First.Trans.Amt),
            CurrencyToNumeric) %>%
  # Replace NA with 0 where needed
  ReplaceValues() %>%
  # Convert to date as needed
  mutate_at(vars(Giving.First.Trans.Dt),
            ToDate, method="mdy")
