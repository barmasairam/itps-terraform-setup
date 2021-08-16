#creating the route53 hosted zone

resource "aws_route53_zone" "primary" {
  name = "ramsaimcec.xyz"
}


#create the record set and also getting alb endpoint

resource "aws_route53_record" "tomcat" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "petclinic-tomcat.ramsaimcec.xyz"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.alb-1.dns_name}"]
}