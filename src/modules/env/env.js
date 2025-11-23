/// <reference types="node" />
// the code below is copied from https://github.com/andrewmclagan/react-env
function isBrowser() {
  return Boolean(typeof window !== 'undefined' && window.__ENV)
}

export default function env(key = '') {
  const prefix = (isBrowser() ? window.__ENV['REACT_ENV_PREFIX'] : process.env.REACT_ENV_PREFIX) || 'REACT_APP'
  console.log("prefix", prefix)
  console.log("isBrowser", isBrowser())
  const safeKey = `${prefix}_${key}`
  console.log("safeKey", safeKey)


  if (isBrowser()) {
    console.log("window.__ENV[safeKey]", window.__ENV[safeKey])
    return window.__ENV[safeKey]
  }

  return process.env[safeKey]
}
