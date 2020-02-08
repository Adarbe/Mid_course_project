# #### Resource ####

#  resource "aws_subnet" "pubsub" {
#   count = 3
#   vpc_id = "${data.aws_vpc.default.id}"
#   cidr_block = "172.31.${2+count.index}.0/24"
#   #cidr_block = "10.0.${2+count.index}.0/24"
#   availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "pubsub ${count.index}"
#   }
# }

# resource "aws_subnet" "prisub" {
#   count = 3
#   vpc_id = "${data.aws_vpc.default.id}"
# #  vpc_id = "${aws_vpc.mid_project.id}"
#   cidr_block = "172.31.${10+count.index}.0/24"
#   #cidr_block = "10.0.${10+count.index}.0/24"
#   availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "prisub ${count.index}"
#   }
# }

# # resource "aws_internet_gateway" "IGW" {
# #   vpc_id = "${data.aws_vpc.default.id}"
# # #  vpc_id = "${aws_vpc.mid_project.id}"
# #   tags = {
# #     Name = "IGW"
# #     }
# #   }

# resource "aws_eip" "nateip" {
#   vpc = true
#   count = 3
#   }

# resource "aws_nat_gateway" "NATGW" {
#   allocation_id = "${element(aws_eip.nateip.*.id, count.index)}"
#   #depends_on = ["aws_internet_gateway.default"]
#   #depends_on = ["aws_internet_gateway.IGW"]
#   subnet_id = "${aws_subnet.prisub[count.index].id}"
#   count = 3
#   tags = {
#     Name = "NATGW ${count.index}"
#    }
#   }



#  ##### Route tables #####

# resource "aws_route_table" "pubroute" {
#   vpc_id = "${data.aws_vpc.default.id}"
#   count = 3
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "igw-3150d54a"
#     #gateway_id = "${aws_internet_gateway.IGW.id}"
#   }
# }

# resource "aws_route_table" "priroute" {
#   vpc_id = "${data.aws_vpc.default.id}"
# # vpc_id = "${aws_vpc.mid_project.id}"
#   count = 3
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = "${aws_nat_gateway.NATGW[count.index].id}"
#   }
# }


# resource "aws_route_table_association" "pubroute" {
#   count = "${length(aws_subnet.pubsub)}"
#   subnet_id = "${element(aws_subnet.pubsub.*.id, count.index)}"
#   route_table_id = "${aws_route_table.pubroute[count.index].id}"
# }

# resource "aws_route_table_association" "priroute" {
#   count = "${length(aws_subnet.prisub)}"
#   subnet_id = "${element(aws_subnet.prisub.*.id, count.index)}"
#   route_table_id = "${aws_route_table.priroute[count.index].id}"
# }