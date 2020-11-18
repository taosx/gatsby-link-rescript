@bs.module("gatsby") external gatsbyLink: ReasonReact.reactClass = "Link"
@bs.module("gatsby") external navigateTo: string => unit = "navigateTo"
@bs.module("gatsby") external withPrefix: string => string = "withPrefix"

@bs.deriving(abstract)
type jsProps = {
  @bs.as("to")
  _to: string,
  activeStyle: Js.nullable<ReactDOMRe.Style.t>,
  style: Js.nullable<ReactDOMRe.Style.t>,
  innerRef: Js.nullable<ReasonReact.reactRef>,
  onClick: Js.nullable<ReactEvent.Mouse.t => unit>,
  activeClassName: Js.nullable<string>,
  className: Js.nullable<string>,
  exact: Js.nullable<bool>,
  strict: Js.nullable<bool>,
}

/* TODO figure out a type-safe way to filter out undefined properties from props */
let filterProps: jsProps => jsProps = %raw(
  `
  function(props) {
    var newProps = {};
    for(var key in props) {
      if(props[key] !== undefined) {
        newProps[key] = props[key];
      }
    }
    return newProps;
  }
`
)

let make = (
  ~_to: string,
  ~activeStyle: option<ReactDOMRe.Style.t>=?,
  ~style: option<ReactDOMRe.Style.t>=?,
  ~innerRef: option<ReasonReact.reactRef>=?,
  ~onClick: option<ReactEvent.Mouse.t => unit>=?,
  ~activeClassName: option<string>=?,
  ~className: option<string>=?,
  ~exact: option<bool>=?,
  ~strict: option<bool>=?,
  children,
) => {
  let jsProps = jsProps(
    ~_to,
    ~activeStyle=Js.Nullable.fromOption(activeStyle),
    ~innerRef=Js.Nullable.fromOption(innerRef),
    ~style=Js.Nullable.fromOption(style),
    ~onClick=Js.Nullable.fromOption(onClick),
    ~activeClassName=Js.Nullable.fromOption(activeClassName),
    ~className=Js.Nullable.fromOption(className),
    ~exact=Js.Nullable.fromOption(exact),
    ~strict=Js.Nullable.fromOption(strict),
  )
  ReasonReact.wrapJsForReason(~reactClass=gatsbyLink, ~props=filterProps(jsProps), children)
}

let navigateTo = navigateTo

let withPrefix = withPrefix
