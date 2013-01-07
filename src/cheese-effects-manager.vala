/*
 * Copyright © 2010 Yuvaraj Pandian T <yuvipanda@yuvi.in>
 * Copyright © 2010 daniel g. siegel <dgsiegel@gnome.org>
 * Copyright © 2008 Filippo Argiolas <filippo.argiolas@gmail.com>
 *
 * Licensed under the GNU General Public License Version 2
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;

const string GROUP_NAME = "Effect";

internal class Cheese.EffectsManager : GLib.Object
{
  public GLib.Array<Effect> effects;

  public EffectsManager ()
  {
    effects = new Array<Effect>();
  }

  /**
   * Add the effects into the manager.
   */
  public void load_effects ()
  {
    GLib.List<Cheese.Effect> effect_list = Cheese.Effect.load_effects ();
    for (int i = 0; i < effect_list.length (); i++)
      effects.append_val (effect_list<Cheese.Effect>.nth (i).data);

    effects.sort ((GLib.CompareFunc)sort_value);

    /* add identity effect as the first in the effect list */
    if (effects.length > 0)
    {
      Effect e = new Effect (_("No Effect"), "identity");
      effects.prepend_val (e);
    }
  }

  /**
   * Search for and return the requested effect.
   *
   * @param name the name of the effect to search for
   * @return the effect that which matches the supplied name, or null
   */
  public Effect ? get_effect (string name)
  {
    for(int i = 0 ; i < effects.length ; ++i){
      if((string)effects.index(i) == name){
        return effects.index(i);
      }
    }
    return null;
  }

  /**
   * A sort function for effects
   *
   * @param a an effect to sort against
   * @param b another effect to sort against
   * @return -1 if a is less than b, 0 if the effects are the same and 1 if a
   * is greater than b
   */
  private static int sort_value (Effect a, Effect b)
  {
    if (a.name.down () < b.name.down ())
      return -1;
    else if (a.name.down () > b.name.down ())
      return 1;
    else
      return 0;
  }
}
