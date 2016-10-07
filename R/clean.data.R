## Data frame setup, data cleaning, general wrangling

# Use dplyr to select only the fields we need
dat <- full.data %>%
  select(Entity.ID, Entity.Record.Status.Desc, Booth.ClassYr.or.RecYr, Booth.Program,
         Booth.Program.Group, Entity.Degreed.Alum.Undergrad.Ind, Entity.Ever.FacStaff.Ind,
         Entity.Parent.Ind, Bus.Title.High.Lvl, Career.Spec.High.Income, Employ.Years.At.Current.Company,
         Master.Addr.Type, Master.Addr.Continent, Gift.Capacity.Numerical.Amt..CR.,
         Research.Capacity, Research.Non.Capacity, Giving.FYs.of.Giving, Giving.FY.in.Last.5,
         Giving.Booth.Allocations.Supported, Giving.Booth.Gifts.Count, Giving.Booth.AF.Gifts,
         Giving.Ever.Pledged.to.Booth, Gift.Cash.Flag, Gift.Stock.Flag, Gift.Donor.Flag..25k,
         Giving.AF.Scholarship, Giving.Student.Support, Giving.First.Trans.Dt, Giving.First.Trans.Amt,
         Spouse.Married.UC.Booth, Rel.Known.Tos.Count, Action.Visit.Count..BUS.,
         Action.NonVisit.Count..BUS., Committees..BUS., Committee.in.Last.3.FY, Committee.Reunion.Active,
         Vol.Acts..BUS., Vol.Acts.Event.Speaker, Events.Vol.Speaker, Vol.Acts.Was.Club.President,
         Vol.Act.Student.Supporter, Alloc.Stewardee.Student.Support, Student.Acts..BUS.,
         Student.Acts..BUS..Leader, Scholarships.Count, Awards..BUS., Events.Attended..BUS.,
         Events.Attended..BUS..Reunion, Events.Attended..BUS..Student, Events.Attended.in.Last.3.FY..BUS.,
         Nonprofit.Leadership.Flag, Non.UChicago.Notable.Vol.Flag, In.Magazine) %>%
  # Create the response variable
  mutate(Gift.Donor.Flag..25k = factor(Gift.Donor.Flag..25k, labels=c("Nondonor", "Donor"))) %>%
  # Remove any duplicate records, and any non-alumni records
  filter(Entity.Record.Status.Desc != "Purgable",
         Booth.Program.Group != "") %>%
  # Create factors as needed
  mutate_at(vars(Entity.Record.Status.Desc, Booth.Program, Booth.Program.Group,
                 Master.Addr.Type, Master.Addr.Continent, Spouse.Married.UC.Booth),
            as.factor) %>%
  # Drop unused factor levels
  droplevels() %>%
  # Convert currency to numeric as needed
  mutate_at(vars(Gift.Capacity.Numerical.Amt..CR., Giving.First.Trans.Amt),
            CurrencyToNumeric) %>%
  # Replace NA with 0 where needed
  ReplaceValues() %>%
  # Convert to date as needed
  mutate_at(vars(Giving.First.Trans.Dt),
            ToDate, method="mdy") %>%
  # But we actually don't need that column; it's just an example
  select(-Giving.First.Trans.Dt)