context Aeroport 
inv: self.id.size() = 3
inv: self.id.matches('[a-zA-Z]*')
inv: Aeroport.allInstances()->forAll(x1, x2 | x1.id <> x2.id)

context CieDeTransport
inv: self.liaisons->forAll(x1, x2 | x1.id.substring(3,x1.id.size()) <> x2.id.substring(3,x2.id.size()))
context Terminal
inv: self.compagnies->forAll(x1, x2 | x1.id.substring(1,2) <> x2.id.substring(1,2))

context Vol
inv: self.id.substring(1,2).matches('[a-zA-Z]*')
and self.id.substring(2).matches('[0-9]*')
and self.compagnies.vols->forAll(x1,x2 |x1.id.substring(1,2) <> x2.id.substring(1,2) or x1 = x2)
inv: self.origine <> self.destination

context SectionAvion
inv: self.sieges->forAll(x1,x2 | x1.price = x2.price)

context Port
inv: self.id.size() = 3
inv: self.id.substring(1,1).toInteger().oclIsUndefined()
and self.id.substring(2,2).toInteger().oclIsUndefined()
and self.id.substring(3,3).toInteger().oclIsUndefined()
inv: Port.allInstances()->forAll(x1, x2 | x1.id <> x2.id)

context Itinéraire
inv: self.getDuration < 21

context CieDeCroisieres
inv: self.itinéraires->forAll(i : Itinéraire | 
  i.ports.first().id = i.ports.last().id)
 
context Paquebot
inv: self.itineraries->forAll(i1, i2 | i1 <> i2 implies i1.expectedArrivalTime <= i2.departureTime or i2.expectedArrivalTime <= i1.departureTime)

context Cabine
inv: self.section.cabins->forAll(c | c.price = self.price)

context Gare 
inv: self.id.size() = 3
inv: self.id.matches('[a-zA-Z]*')
inv: Gare.allInstances()->forAll(x1, x2 | x1.id <> x2.id)

context Réservation
pre: self.flight.availableSeats > 0
pre: self.itinerary.availableCabins > 0
inv: self.flight.availableSeats->includes(self.seat)
inv: self.itinerary.availableCabins->includes(self.cabin)

context Siège
inv: (self.reserved and self.passenger <> null) implies self.status = 'confirmed'