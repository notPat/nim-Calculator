import std/parseutils
import std/strformat

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

proc calc(expr : string) : float =

  var ex : string = expr

  if '(' in ex and ')' in ex:
    var
      pos1 :int = ex.find('(')
      pos2 :int = len ex
    pos2 -= 1

    while pos2 > pos1:
      if ex[pos2] == ')':
        break
      pos2 -= 1

    pos1 += 1
    pos2 -= 1

    var temp = ex[pos1..pos2]
    if ')','(' in temp:
      var i = temp.find(')')


    let num : float = calc(ex[pos1..pos2])
    
    ex = ex[0..pos1-2] &  fmt("{num}") & ex[pos2+2..^1]





      
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
