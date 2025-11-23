import { EnvironmentVariables } from './models/environment';
import env from './modules/env/env';

function App() {
  const value = env(EnvironmentVariables.googleUrl);;
  return <div>url env value: {value}</div>;
}

export default App;
