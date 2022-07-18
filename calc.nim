import std/parseutils

proc parse(ex : string, op : char) : (string, string)=

  var
    i : int = ex.find(op)

  var
    right : string = ex[i+1 .. ^1]
    left : string = ex[0 .. i-1]
  return (left, right)

proc c(a : float, b : float, op : char) : float =
  case op
  of '+' :
    return a+b
  of '-':
    return a-b
  of '*' :
    return a*b
  of '/' :
    return a/b
  else:
    return 0

proc calc(ex : string) : float =
  if '(' in ex or ')' in ex:
    for i in range(ex.length):
      


  if not('*' in ex or '/' in ex or '+' in ex or '-' in ex):
    var res : float
    discard parsefloat(ex, res)
    return res

  for op in ['+', '-', '*', '/']:
    if op in ex:
      let (left, right) = parse(ex, op)
      return c(calc(left), calc(right), op)

while true:
  echo "Expr. : "
  var input : string = readline(stdin)
  echo "Result : "
  echo calc(input)
