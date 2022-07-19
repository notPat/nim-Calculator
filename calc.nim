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

  if '(' in ex and (not (')' in ex)) or (not ('(' in ex)) and ')' in ex:
    echo "Error, no closed braces"
    return 0.00

  if '(' in ex and ')' in ex:

    while '(' in ex and ')' in ex:

      var
        braces : seq[int] = @[]
        braceCnt : int = 0


      for idx, s in ex[0..^1]:
        if s == '(':
          braces.add(idx+1)
          braceCnt += 1
        elif(s == ')'):
          braces.add(-1*(idx+1))
          braceCnt -= 1

      if braceCnt != 0:
        echo ("Error, no closed braces")
        return 0.00

      for idx in 0 .. braces.len-2:

        if braces[idx] > 0 and braces[idx+1] < 0:
          var
            pos1 = braces[idx]-1
            pos2 = (braces[idx+1]*(-1))-1

          let num = calc(ex[pos1+1..pos2-1])

          ex[pos1..pos2] = fmt("{num}")
          break



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
