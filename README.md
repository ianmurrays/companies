# API Documentation

## Companies

### GET /api/companies

Returns a list of companies. Example

    curl -i http://0.0.0.0:9292/api/companies
    
Returns

    [
      {
        "id": 2,
        "name": "Doe Ltd.",
        "address": "123 Steep Street",
        "city": "San Francisco, CA",
        "country": "USA",
        "email": null,
        "phone": null
      }
    ]

### GET /api/companies/:id

Returns details of the company with `:id` and its directors. For example:

    curl -i http://0.0.0.0:9292/api/companies/2

Returns:

    {
        "address": "holi",
        "city": "stgo",
        "country": "chileasdf",
        "directors": [
            {
                "id": 2,
                "name": "John Doe"
            },
            {
                "id": 4,
                "name": "Jane Doe"
            }
        ],
        "email": null,
        "id": 2,
        "name": "ian",
        "phone": null
    }

### POST /api/companies

Creates a company with the posted JSON payload. Example:

    curl -i --data '{"name":"Company Ltd.", "address": "123 Downhill Rd.", "city": "Santiago", "country": "Chile"}' http://0.0.0.0:9292/api/companies

Will return 

    {
        "address": "123 Downhill Rd.",
        "city": "Santiago",
        "country": "Chile",
        "email": null,
        "id": 6,
        "name": "Company Ltd.",
        "phone": null
    }

Failing to send a required field will return an error:

    {
        "error": "validation_failed",
        "errors": [
            "Country can't be blank"
        ]
    }

### PUT /api/companies/:id

Updates a company with the posted JSON payload. Example:

    curl -i -X PUT --data '{"name":"Company Limited"}' http://0.0.0.0:9292/api/companies/6

Returns the new company object:

    {
        "address": "123 Downhill Rd.",
        "city": "Santiago",
        "country": "Chile",
        "email": null,
        "id": 6,
        "name": "Company Limited",
        "phone": null
    }

### DELETE /api/companies/:id

Deletes a company. Example

    curl -i -X DELETE http://0.0.0.0:9292/api/companies/6

Returns a status of `204 No Content`.

## Directors

### GET /api/companies/:company_id/directors/:id

Returns details of a director. For example:

    curl -i http://0.0.0.0:9292/api/companies/2/directors/2

Returns 

    {
        "company_id": 2,
        "id": 2,
        "name": "John Doe"
    }

### GET /api/companies/:company_id/directors/:id/passport

Redirects (via a status `302`) to the PDF of the passport of the director.

    curl -i http://0.0.0.0:9292/api/companies/2/directors/22/passport

Returns

    HTTP/1.1 302 Found
    Location: http://0.0.0.0:9292/uploads/john.doe.pdf

### POST /api/companies/:company_id/directors

Creates a director with the posted JSON payload. For example:

    curl -i -X POST --data '{"name": "Jamie Doe"}' http://0.0.0.0:9292/api/companies/2/directors

Returns 

    {
        "company_id": 2,
        "id": 23,
        "name": "Jamie Doe"
    }

### POST /api/companies/:company_id/directors/upload

Uploads a passport PDF and returns its temporary id. You can use this id to attach it to a director. It's designed this way to be used by Javascript frontends.

    curl -i -X POST -F "passport=@/Users/macbook/Desktop/passport.pdf" http://0.0.0.0:9292/api/companies/2/directors/upload

This returns:

    {"passport_cache": "1386111293-90552-1809/passport.pdf"}

To later create or update a director using this id, you can just add it to the payload, like so:

    curl -i -X POST --data '{"name": "Jamie Doe", "passport_cache": ""1386111293-90552-1809/passport.pdf""}' http://0.0.0.0:9292/api/companies/2/directors

### PUT /api/companies/:company_id/directors/:id

Creates a director with the posted JSON payload. For example:

    curl -i -X PUT --data '{"name": "Jamie Doe Jr."}' http://0.0.0.0:9292/api/companies/2/directors/20

Returns 

    {
        "company_id": 2,
        "id": 20,
        "name": "Jamie Doe Jr."
    }

### DELETE /api/companies/:company_id/directors/:id

Deletes a director. Example:

    curl -i -X DELETE http://0.0.0.0:9292/api/companies/2/directors/23
