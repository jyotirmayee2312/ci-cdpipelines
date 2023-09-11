# Configure AWS provider
provider "aws" {
  region = "ap-south-1" 
}

# Create S3 bucket 
resource "aws_s3_bucket" "website" {
  bucket = "jyotirmayee-bucket"
  acl    = "public-read"

  policy = <<EOF
{
  "Version": "2012-10-17",  
  "Statement": [
    {
      "Sid": "PublicReadGetObject",  
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::my-static-website-bucket/*"]
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # Set region
  region = "ap-south-1" 
}

# Print endpoint
output "website_endpoint" {
  value = aws_s3_bucket.website.website_endpoint 
}
