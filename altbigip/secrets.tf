#
# Create random password for BIG-IP
#
resource "random_password" "password" {
    length           = 16
    min_upper        = 1
    min_lower        = 1
    min_numeric      = 1
    min_special      = 1
    special          = true
    override_special = "_%@"
}