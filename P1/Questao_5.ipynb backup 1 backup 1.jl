{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "**5)** In a wind tunnel, flow velocities can be measured with the aid of a Pitot tube connected to a manometer---there are two connections as shown in the picture, i.e., the stagnation (total) pressure, P_t, from the frontal orifice, and the static (thermodynamic) pressure, P_s, from the side orifices---through the definition of dynamic pressure, P_d = ρu²/2, and the Bernoulli's equation for a streamline: P_s+P_d+P_h=P_t=const., where P_h is the hydrostatic pressure. For air, differences in P_h can be neglected and ρ is obtained from the ideal gas equation of state, with the absolute pressure measured on a barometer, and the temperature measured on a mercury column thermometer. Assuming that all uncertainties are given for 95% confidence levels based on 5 measurements, and that the manometric fluid has γ=(9.771 ± 0.006)kN/m³, and the readings are as follows: total pressure reading of (3.1 ± 0.2)cm, static pressure reading of (4.7 ± 0.2)cm, temperature reading of (29.5 ± 0.5)°C, and baremeter reading of (980.5 ± 1.5)hPa. Determine:\n",
    "\n",
    "**a)** The nominal air density, in kg/m³, is\n",
    "\n",
    "**b)** The air density uncertainty, in kg/m³, is\n",
    "\n",
    "**c)** The nominal dynamic pressure, in Pa, is\n",
    "\n",
    "**d)** The dynamic pressure uncertainty, in Pa, is\n",
    "\n",
    "**e)** The nominal flow velocity, in m/s, is\n",
    "\n",
    "**f)** The flow velocity uncertainty, in m/s, is\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/latex": [
       "$9.771 \\pm 0.006$"
      ],
      "text/plain": [
       "9.771 ± 0.006"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "using Measurements\n",
    "\n",
    "P_t = (2.8 ± 0.1)\n",
    "P_s = (4.3 ± 0.1)\n",
    "P_b = (960 ± 1.5)\n",
    "T = (26.5 + 273.15 ± 3.5)\n",
    "γ = (9.771 ± 0.006)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [
    {
     "ename": "LoadError",
     "evalue": "KeyError: key :PropsSI not found",
     "output_type": "error",
     "traceback": [
      "KeyError: key :PropsSI not found",
      "",
      "Stacktrace:",
      " [1] __getproperty(o::PyObject, s::Symbol)",
      "   @ PyCall C:\\Users\\Alessandro\\.julia\\packages\\PyCall\\BD546\\src\\PyCall.jl:307",
      " [2] getproperty(o::PyObject, s::Symbol)",
      "   @ PyCall C:\\Users\\Alessandro\\.julia\\packages\\PyCall\\BD546\\src\\PyCall.jl:312",
      " [3] top-level scope",
      "   @ In[6]:6",
      " [4] eval",
      "   @ .\\boot.jl:360 [inlined]",
      " [5] include_string(mapexpr::typeof(REPL.softscope), mod::Module, code::String, filename::String)",
      "   @ Base .\\loading.jl:1094"
     ]
    }
   ],
   "source": [
    "#The nominal air density, in kg/m³, is\n",
    "\n",
    "using PyCall\n",
    "\n",
    "CP = pyimport(\"CoolProp.CoolProp\")\n",
    "R = CP.PropsSI(\"air\",\"gas_constant\")\n",
    "M = CP.PropsSI(\"Air\",\"molarmass\")\n",
    "Rₐᵢᵣ = (R / M/ 1000)\n",
    "ρ = ((P_b / 10) / (Rₐᵢᵣ * T))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "ename": "LoadError",
     "evalue": "UndefVarError: ρ not defined",
     "output_type": "error",
     "traceback": [
      "UndefVarError: ρ not defined",
      "",
      "Stacktrace:",
      " [1] top-level scope",
      "   @ In[3]:6",
      " [2] eval",
      "   @ .\\boot.jl:360 [inlined]",
      " [3] include_string(mapexpr::typeof(REPL.softscope), mod::Module, code::String, filename::String)",
      "   @ Base .\\loading.jl:1094"
     ]
    }
   ],
   "source": [
    "#The nominal dynamic pressure, in Pa, is\n",
    "#The dynamic pressure uncertainty, in Pa, is\n",
    "\n",
    "g = (9.81)\n",
    "ρₗ = γ * 1000/ g\n",
    "u = √(2 * (((P_s - P_t) / 100 * ρₗ * g/ ρ)))\n",
    "P_d = ρ * u^2 / 2"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "ename": "LoadError",
     "evalue": "UndefVarError: u not defined",
     "output_type": "error",
     "traceback": [
      "UndefVarError: u not defined",
      "",
      "Stacktrace:",
      " [1] top-level scope",
      "   @ :0",
      " [2] eval",
      "   @ .\\boot.jl:360 [inlined]",
      " [3] include_string(mapexpr::typeof(REPL.softscope), mod::Module, code::String, filename::String)",
      "   @ Base .\\loading.jl:1094"
     ]
    }
   ],
   "source": [
    "#The nominal flow velocity, in m/s, is\n",
    "#The flow velocity uncertainty, in m/s, is\n",
    "\n",
    "u"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "hide_input": false,
  "kernelspec": {
   "display_name": "Julia 1.6.1",
   "language": "julia",
   "name": "julia-1.6"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.6.1"
  },
  "latex_envs": {
   "LaTeX_envs_menu_present": true,
   "autoclose": false,
   "autocomplete": true,
   "bibliofile": "biblio.bib",
   "cite_by": "apalike",
   "current_citInitial": 1,
   "eqLabelWithNumbers": true,
   "eqNumInitial": 1,
   "hotkeys": {
    "equation": "Ctrl-E",
    "itemize": "Ctrl-I"
   },
   "labels_anchors": false,
   "latex_user_defs": false,
   "report_style_numbering": false,
   "user_envs_cfg": false
  },
  "toc": {
   "base_numbering": 1,
   "nav_menu": {},
   "number_sections": true,
   "sideBar": true,
   "skip_h1_title": false,
   "title_cell": "Table of Contents",
   "title_sidebar": "Contents",
   "toc_cell": false,
   "toc_position": {},
   "toc_section_display": true,
   "toc_window_display": false
  },
  "varInspector": {
   "cols": {
    "lenName": 16,
    "lenType": 16,
    "lenVar": 40
   },
   "kernels_config": {
    "python": {
     "delete_cmd_postfix": "",
     "delete_cmd_prefix": "del ",
     "library": "var_list.py",
     "varRefreshCmd": "print(var_dic_list())"
    },
    "r": {
     "delete_cmd_postfix": ") ",
     "delete_cmd_prefix": "rm(",
     "library": "var_list.r",
     "varRefreshCmd": "cat(var_dic_list()) "
    }
   },
   "types_to_exclude": [
    "module",
    "function",
    "builtin_function_or_method",
    "instance",
    "_Feature"
   ],
   "window_display": false
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
