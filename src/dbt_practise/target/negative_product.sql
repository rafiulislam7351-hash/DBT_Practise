SELECT *
FROM
    {{ref("bronze_product")}}
WHERE
    list_price<0