import './App.css'

function Recipes({recipes}) {
  return (
    <>
      <h2>Recipe results</h2>
      <ul>
        {recipes.map((recipe => (
          <li key={recipe.recipe.uri}>{recipe.recipe.label}</li>
        )
        ))}
      </ul>
    </>
  )
}

export default Recipes
